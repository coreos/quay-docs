# Documentation for Quay.io.

[![Docker Repository on Quay.io](https://quay.io/repository/coreos/quay-docs/status "Docker Repository on Quay.io")](https://quay.io/repository/coreos/quay-docs)

## Run in a container (on prem)

```
docker run -p 4000:4000 quay.io/coreos/quay-docs
```

## Run locally (development)

To edit using Jekyll:
```
jekyll serve --watch --baseurl=""
```
