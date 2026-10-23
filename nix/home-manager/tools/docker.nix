# Docker itself is installed outside Nix.
{
  my.human.aliases.dc = "docker-compose";

  my.human.init = ''
    function drm() {
        sudo docker ps -a | sed 1d | fzf --no-sort -m | awk "{ print $1 }" | xargs -r docker rm
    }

    function drmi() {
        sudo docker images | sed 1d | fzf --no-sort -m | awk "{ print $1 }" | xargs -r docker rmi
    }
  '';
}
