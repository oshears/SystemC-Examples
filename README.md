# SystemC Examples

## Examples from EDA Playground
- [Counter](https://www.edaplayground.com/x/3cf)
- [Memory](https://www.edaplayground.com/x/56Q4)


# Docker

- To run the container with SSH key:

```bash
docker run -it \
  --name systemc_dev_container \
  -v "$SSH_AUTH_SOCK:/ssh-auth.sock" \
  -e SSH_AUTH_SOCK="/ssh-auth.sock" \
  -d \
  systemc-dev:latest
```

- To update docker image:

```bash
# Optional: Make a new tag
docker tag systemc-dev:latest ghcr.io/oshears/systemc-dev:latest

# Commit current container as the new image
docker commit systemc_dev_container ghcr.io/oshears/systemc-dev:latest

# Push the new image to GHCR
docker push ghcr.io/oshears/systemc-dev:latest
```