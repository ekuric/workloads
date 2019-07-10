# Job Parameters here:
export ORCHESTRATION_HOST="54.186.25.63"
export ORCHESTRATION_USER=root

# export WORKLOAD_IMAGE="quay.io/akrzos/scale-ci-workload"
# export WORKLOAD_IMAGE="quay.io/openshift-scale/scale-ci-workload"

#export WORKLOAD_JOB_NODE_SELECTOR=true
#export WORKLOAD_JOB_TAINT=true
#export WORKLOAD_JOB_PRIVILEGED=true
export WORKLOAD_JOB_NODE_SELECTOR=false
export WORKLOAD_JOB_TAINT=false
export WORKLOAD_JOB_PRIVILEGED=true
export KUBECONFIG_FILE='~/.kube/config'

export PBENCH_SSH_PRIVATE_KEY_FILE='~/.ssh/id_rsa_perf'
export PBENCH_SSH_PUBLIC_KEY_FILE='~/.ssh/id_rsa_perf.pub'
export ENABLE_PBENCH_AGENTS=true
export PBENCH_SERVER=pbench.dev.openshift.com

export SCALE_CI_RESULTS_TOKEN=

# PodVertical workload specific parameters:
export FIOTEST_TEST_PREFIX=fiotest
export FIOTEST_CLEANUP=false
export FIOTEST_BASENAME=fiotest
export FIOTEST_MAXPODS=2
export FIOTEST_POD_IMAGE="quay.io/ekuric/elkofio:latest"
export FIOTEST_STEPSIZE=1
export FIOTEST_PAUSE=0
export FIOTEST_STORAGE_SIZE="2Gi"
export FIOTEST_STORAGECLASS="csi-rbd"
export ACCESS_MODES="ReadWriteOnce"
export FIOTEST_BS="4k"
export FIOTEST_FILENAME="/mnt/pvcmount/f2"
export FIOTEST_FILESIZE="1GB"
export FIOTEST_RUNTIME=180
export FIOTEST_RAMPTIME=10
export FIOTEST_DIRECT="1"
export FIOTEST_IODEPTH=32
export FIOTEST_TESTTYPE="write"

#export FIOTEST_TEST=true
####################################################################################################
# Start Jenkins Build:
####################################################################################################
# List the environment variables.
env
set -o pipefail
set -eux
 
# git clone https://547a8993de8581eeaa7b2a8b3cf5ca185704f971@github.com/redhat-performance/perf-dept.git
# export PUBLIC_KEY=${WORKSPACE}/perf-dept/ssh_keys/id_rsa_perf.pub
# export PRIVATE_KEY=${WORKSPACE}/perf-dept/ssh_keys/id_rsa_perf
# chmod 600 ${PRIVATE_KEY}
#export PUBLIC_KEY=~/code/perf-dept/ssh_keys/id_rsa_perf.pub
#export PRIVATE_KEY=~/code/perf-dept/ssh_keys/id_rsa_perf
export PUBLIC_KEY=~/.ssh/id_rsa_perf.pub
export PRIVATE_KEY=~/.ssh/id_rsa_perf

# Create inventory File:
echo "[orchestration]" > inventory
echo "${ORCHESTRATION_HOST}" >> inventory

export ANSIBLE_FORCE_COLOR=true
ansible --version
time ansible-playbook -v -i inventory /home/elvir/github/ekuric/workloads/workloads/fio.yml

####################################################################################################
# Post Jenkins Build Clean up:
####################################################################################################
#rm -rf inventory

