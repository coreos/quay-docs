FROM jekyll/jekyll:builder

RUN curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip && \
	unzip awscli-bundle.zip && \
	./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
	rm -rf awscli-bundle.zip awscli-bundle

WORKDIR /srv/jekyll

COPY run.sh /
COPY build.sh /

ADD . /srv/jekyll

CMD ["jekyll", "serve"]
