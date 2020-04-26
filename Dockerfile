FROM ruby:2.3.1

RUN apt-get update -yqq \
	&& apt-get install -yqq --no-install-recommends \
		postgresql-client \
		nodejs \
		qt5-defaults \
		libqt5webkit5-dev \
	&& apt-det -q clean \
	&& rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD rails server -b 0.0.0.0