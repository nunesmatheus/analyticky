FROM ruby:2.7.2

RUN apt-get update && apt-get install -y curl software-properties-common vim locales
RUN apt-get install -y libc-ares2 --no-install-recommends

RUN mkdir -p /analyticky
WORKDIR /analyticky/

COPY . /analyticky/

RUN gem install bundler:2.1.4

RUN bundle install -j "$(getconf _NPROCESSORS_ONLN)" --retry 3

EXPOSE 3000

# Extra tools:
# 1. less
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y less

# TERM config
RUN echo "export TERM=rxvt-unicode" >> ~/.bashrc
RUN echo export LS_OPTIONS='--color=auto' >> ~/.bashrc
RUN echo 'alias ls="ls $LS_OPTIONS"' >> ~/.bashrc
RUN echo 'alias ll="ls $LS_OPTIONS -l"' >> ~/.bashrc

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["rails", "s", "-b", "0.0.0.0"]
