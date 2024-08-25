# Base image
# Base image
FROM ruby:3.2.2

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production"

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code
COPY . /app

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]