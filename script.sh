version: '3.7'

services:
  rancher:
    image: rancher/rancher:latest
    container_name: rancher-server
    restart: unless-stopped
    ports:
      - "8092:80"     # HTTP -> exposed on 8092
      - "8089:443"    # HTTPS -> exposed on 8089
    volumes:
      - rancher-data:/var/lib/rancher
    privileged: true  # Required for Rancher

volumes:
  rancher-data:
