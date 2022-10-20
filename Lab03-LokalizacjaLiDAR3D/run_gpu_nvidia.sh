#!/bin/bash
xhost +local:root

################################################################################
# Build from instruction in Dockerfile. Shared folder is entire catkin workspace
# so set it up normally, by sourcing /opt/ros/noetic/setup.bash and running
# catkin_make in container and then You can do normal from within the workspace
# source devel/setup.bash. Edit on host and build / run from container.
################################################################################

XAUTH=/tmp/.docker.xauth
 if [ ! -f $XAUTH ]
 then
     xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
     if [ ! -z "$xauth_list" ]
     then
         echo $xauth_list | xauth -f $XAUTH nmerge -
     else
         touch $XAUTH
     fi
     chmod a+r $XAUTH
 fi

docker stop ARM_03 || true && docker rm ARM_03 || true

docker run -it \
    -v /home/js/Projects/ARM/MyLabARM/Lab03-LokalizacjaLiDAR3D/catkin_ws:/catkin_ws \
    --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --env="NVIDIA_VISIBLE_DEVICES=all" \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --privileged \
    --network=host \
    --name="ARM_03" \
    lab03:latest \
    /bin/bash
