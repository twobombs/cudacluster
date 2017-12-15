# this scripts parses all containers on a host and deploys worker payloads on vGPU container nodes through docker exec 
# as an example cuburn is used for generating either a segment of a fractal flame or a whole frame with temporal displacement
# this as a POC for QC entangled workloads that will, when ready, host ~40k+ correlated elements @ 8Qbit emulator (8n! tensors)
#

docker exec -ti $(docker ps -aq) cuburn.sh

#watch the load on the GPUs
watch -n0.1 nvidia-smi
