FROM ruby:3.3.6
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN apt-get update -qq \
 && apt-get install -y ca-certificates curl gnupg wget \
 && mkdir -p /etc/apt/keyrings \
 && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
 && NODE_MAJOR=19 \
 && wget --quiet -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update -qq \
 && apt-get install -y build-essential libpq-dev nodejs yarn

RUN mkdir /pack_ready
WORKDIR /pack_ready

RUN gem install bundler:2.3.17
COPY Gemfile /pack_ready/Gemfile
COPY Gemfile.lock /pack_ready/Gemfile.lock
COPY yarn.lock /pack_ready/yarn.lock
RUN bundle install
RUN yarn install

COPY . /pack_ready

EXPOSE 3000
CMD ["sh", "-c", "bin/rails server -b 0.0.0.0 -p ${PORT:-3000}"]