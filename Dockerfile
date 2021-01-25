# Dockerfile for Ruby environment, not used with VSCode
#
FROM ubuntu:18.04

MAINTAINER Petr Budík petr.budik96@gmail.com

# Run update, install other useful commands
RUN apt-get update && \
    	apt-get install -y libssl-dev libreadline-dev zlib1g-dev gcc make curl nano less locales git && \
    	rm -rf /var/lib/apt/lists/* && \
		locale-gen cs_CZ.utf8

ENV LANG cs_CZ.utf8
ENV LANGUAGE cs_CZ:cs
ENV LC_ALL cs_CZ.utf8

ENV home_folder="/root"
WORKDIR $home_folder

# Install Ruby
RUN git clone https://github.com/rbenv/rbenv.git .rbenv && \
	export PATH="$HOME/.rbenv/bin:$PATH" && \
	eval "$(rbenv init -)" && \
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bashrc && \
	echo 'eval "$(rbenv init -)"' >> .bashrc && \
	git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build && \
	rbenv install 2.7.1 && \
	rbenv global 2.7.1

# Add SemestralWork_RUB
RUN git clone https://github.com/budikpet/SemestralWork_RUB.git && \
	echo 'alias build_sem_work="gem build renamer.gemspec && gem install --development ./renamer-0.1.0.gem"' >> .bashrc