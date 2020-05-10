# docker-recoll-webui
recoll with webui in a docker container

- used python3 and new updated recoll-web-ui https://framagit.org/medoc92/recollwebui/ version
- creates a python standalone recoll server inside a docker container listening on port 8080
- to start indexing run this command on your system:
    `docker exec CONTAINER_ID recollindex`
- change `CONTAINER_ID` and paths to your needs
- settings for recoll are stored in `/root/.recoll/recoll.conf`
- database is stored in `/root/.recoll/xapiandb`
- both settings and database are in persistent volume mapped to /root/.recoll
- up to 10 different folders (with their subfolders) can be indexed (/docs0 to /docs9)
# links

- source project: https://github.com/PeroqDev/docker-recoll-webui
- forked from: https://github.com/amsaravi/docker-recoll-webui
- docker hub: https://hub.docker.com/repository/docker/peroq/recoll
# installation steps

- in docker start the wizard to create a docker container from this image: mount <your documents folder> to `/docs0`
  set up port mapping to 8080 (defaults do also work)
- for simplicity there is no user level configuration. you can maintain your container and change configs in `/root/.recoll/recoll.conf` and use docker exec command (not run command) to rebuild index
- to run the indexer as a time-based task on a synology nas download `recollindex.sh` https://github.com/amsaravi/docker-recoll-webui/blob/local_gpg/recollindex.sh, place it somewhere on your system, make it executable (in a shell run: `chmod 775 recollindex.sh`) and remember to modify `CONTAINER_ID`
