FROM golang:1.5
RUN apt-get update && apt-get install -yqq aspell aspell-en libaspell-dev tesseract-ocr tesseract-ocr-eng imagemagick optipng exiftool libjpeg-progs webp
ADD docker/meme.traineddata /usr/share/tesseract-ocr/tessdata/meme.traineddata
RUN mkdir -p /etc/mandible /tmp/imagestore
ENV MANDIBLE_CONF /etc/mandible/conf.json
ADD . /go/src/github.com/Imgur/mandible
WORKDIR /go/src/github.com/Imgur/mandible
RUN go get golang.org/x/tools/cmd/vet
RUN go get -v ./...
RUN go install -v ./...
RUN ./goclean.sh
CMD ["mandible"]
