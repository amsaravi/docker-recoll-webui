# docker-recoll-webui
recoll with webui in a docker container

- used python3 and new updated recoll-web-ui https://framagit.org/medoc92/recollwebui/ version
- creates a python standalone recoll server inside a docker container listening on port 8080
- to start indexing run this command on your system:
    `docker exec CONTAINER_ID recollindex`
- change `CONTAINER_ID` and paths to your needs
- settings for recoll are stored in `/root/.recoll/recoll.conf`
- the path of what will be indexed is `/docs`
# links

- source project: https://github.com/amsaravi/docker-recoll-webui
- docker hub: https://hub.docker.com/repository/docker/amsaravi/recoll-web-ui
# installation steps

- in docker start the wizard to create a docker container from this image: mount <your documents folder> to `/docs` set up port mapping (defaults do also work)
- for simplicity there is no user level configuration. you can maintain your container and change configs in `/root/.recoll/recoll.conf` and use docker exec command (not run command) to rebuild index
- to run the indexer as a time-based task on a synology nas download `recollindex.sh` https://github.com/amsaravi/docker-recoll-webui/blob/local_gpg/recollindex.sh, place it somewhere on your system, make it executable (in a shell run: `chmod 775 recollindex.sh`) and remember to modify `CONTAINER_ID`
