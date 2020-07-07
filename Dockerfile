FROM alpine/git as theme
COPY . /data
WORKDIR /data
RUN rm -rf themes/*
RUN git clone https://github.com/matcornic/hugo-theme-learn themes/hugo-theme-learn

FROM klakegg/hugo as builder
COPY --from=theme /data /data
COPY *.md /data/content/AWS/
COPY _index.md /data/content/
WORKDIR /data
RUN hugo

FROM nginx:alpine
COPY --from=builder /data/public /usr/share/nginx/html

EXPOSE 80