# Mosaic: Making Serverless Performance-Portable with Lazy Hardware Binding

**Premature Hardware Binding is the Root of all Evil! Making Serverless Performance-Portable with Lazy Hardware Binding.** *Serhii Ivanenko, Carlos Segarra, and Rodrigo Bruno.*

Mosaic is a serverless platform featuring a runtime and a scheduler. The runtime utilizes lazy hardware binding to enable serverless functions to benefit from hardware-specific optimizations.

**This artifact accompanies the paper accepted at ATC 2026.**

## Downloading the Artifact

The artifact is presented in a form of source code. To download the artifact, simply clone this repository including all submodules:

```
git clone --recurse-submodules https://github.com/cloudsys-dpss-inescid/mosaic.git
```

## Reproducing Paper Results

Below, you will find instructions to reproduce the results presented in the paper's Evaluation section. The order of steps below might not match the order of experiments as they appear in the paper.

**Important note 1:** some experiments assume using AWS EC2 instances to evaluate performance on different CPU types. Harnessing hardware heterogeneity is the main point of the paper, and evaluation in the paper revolves around three specific types of EC2 instances. Running experiments in AWS is fully automated with the use of Terraform and Ansible. Running the experiments in AWS ***is not free*** (estimated <5 USD). All experiment scripts (`run.sh`) clean up EC2 instances after running. If any of the `run.sh` scripts fail mid-flight, make sure to run `terraform destroy` yourself in that directory.

**Important note 2:** after all AWS experiments, the only AWS resource expected to be left on your account is the S3 bucket. You can remove it either manually or by going to `aws/setup-s3` and run `terraform destroy` there.

**Important note 3:** experiment #3 (cold starts) requires `sudo` permissions to set up network bridge for function runtime instances. Without this network bridge, runtime instances will not be able to download function code/library tiles/input files.

### Software Prerequisites

This guide was tested on Debian GNU/Linux 13 (trixie), Linux kernel version 6.12.41+deb13-amd64.

Below, you can find a list of required software and installation instructions (for Ubuntu/Debian Linux). Skip these instructions if you already have this software installed.

#### 1. Ansible

Assuming Ubuntu/Debian:

```
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```

Source: https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html

#### 2. Terraform

Installing Terraform requires running multiple commands (assuming Ubuntu/Debian):

```
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
$ wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
$ gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
$ sudo apt update
$ sudo apt-get install terraform
```

Source: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

#### 3. AWS CLI tool

```
$ curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash
```

Source: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions

#### 4. Docker

#### 5. Rust toolchain

Required for building Rust benchmarks locally in Experiment #3:

```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
$ source /home/$USER/.cargo/env && rustup target add wasm32-wasip1 # Adding Wasm compilation toolchain.
```

Source: https://rust-lang.org/tools/install/ and https://doc.rust-lang.org/rustc/platform-support/wasm32-wasip1.html

#### 6. Various tools

```
$ sudo apt-get update
$ sudo apt-get install netcat-openbsd libssl-dev pkg-config build-essential apache2-utils
```

### AWS Setup

This step is a common prerequisite for all experiments that run on AWS infrastructure.

Account and credentials setup:

0. If needed, create an AWS account.
1. Go to https://us-east-1.console.aws.amazon.com/console/home, click on your name (in the header, top-right) -> **Security credentials**.
2. Section **Access keys**, create the access key, and note both **Access key** and **Secret access key**.
3. In `setup.sh`, fill the `AWS_ACCESS_KEY_ID` with **Access key** and `AWS_SECRET_ACCESS_KEY` with **Secret access key** from the previous step.
4. No need to update `AWS_DEFAULT_REGION` in `setup.sh`.

Pre-creating AWS infrastructure required for experiments:

1. Run `source setup.sh` in the root of the repository.
2. Go to `aws/setup-s3` and run `bash run.sh`. This will create an S3 bucket - takes <1 minute.
3. Go to `aws/compile` and run `bash run.sh`. This will create upload FFmpeg compilation artifacts to the S3 bucket - takes ~12 minutes.

### 1. Performance Microbenchmarks (Section 4.3, Figure 9)

This experiment runs on AWS infrastructure. Local hardware does not matter.

**Note:** By default, this benchmark executes 500 iterations of every benchmark (100 warmup iterations and 400 recorded iterations). It is **highly recommended** to execute this experiment with default number of iterations for accurate results. To make the experiment shorter (e.g., to make sure the system just works), update the `Run latency test` play in the `aws/lm-mean-latency/bench.yml` playbook like this:

```
# Adding "WORKLOAD=10 WARMUP=2" before the Bash command.
shell: "export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java)))) && WORKLOAD=10 WARMUP=2 bash test.sh"
```

Steps to execute:

1. Go to `aws/lm-mean-latency` and run `bash run.sh`. This will run the throughput experiment - takes ~33 minutes if running 2+10 iterations per benchmark. Running the experiment without reducing the number of iterations can take multiple hours.

After the experiment is finished, you can generate the plot (`throughput.pdf`) as in Figure 9 by running:

```
$ cd aws/lm-mean-latency/results
$ python3 plot-throughput-paper.py # Assumes matplotlib is installed.
# Open `throughput.pdf` to see the results.
```

### 2. Storage Requirements (Section 4.4, Figure 10a)

This experiment runs on AWS infrastructure. Local hardware does not matter.

Steps to execute:

1. Go to `aws/build-storage` and run `bash run.sh`. This will run the storage experiment - takes ~20 minutes.

After the experiment is finished, you can generate the plot (`storage-footprint.pdf`) as in Figure 10a by running:

```
$ cd aws/build-storage/results
# The argument is a path to trace that will be generated in Experiment #4
$ python3 plot-storage.py ../../../scheduler/azure-dataset/output/trace-60min.csv
# Open `storage-footprint.pdf` to see the results.
```

**Note 1:** this plotting script expects a path to a trace we will generate in Experiment #4.

**Note 2:** the actual numbers on the plot depend on the trace to which you apply the calculated storage numbers. Short traces feature fewer functions, therefore, storage footprint will be lower. The trace used in paper was 1 hour long.

### 3. Cold Starts (Section 4.4, Figure 10b)

This experiment runs locally but does not require more than 8 GB of memory and 2 CPUs.

Steps to execute:

1. Go to `platform` and run `bash setup.sh` - answer "y" to all questions and enter `sudo` password when prompted. This step sets up infrastructure, builds runtime proxies as Docker images and benchmarks. Depending on the machine, this step can take up to 20-30 minutes.
2. Go to `platform/lambda-manager/tests/cold-start` and run `bash test.sh`. This step usually takes under 5 minutes.

After the experiment is finished, you can generate the plot (`cold-starts.pdf`) as in Figure 10b by running:

```
$ python3 plot-cold-starts.py # In the same directory as the experiment script.
# Open `cold-starts.pdf` to see the results.
```

### 4. Scheduling Experiment (Section 4.2, Figure 8)

This experiment runs locally and ideally runs on a machine with >16 GB of memory and >8 CPUs. This experiment assumes running ~100 lightweight Java processes along with the scheduler, which is a bigger Java process.

Steps to execute:

1. Go to `scheduler` and run `bash setup.sh`. This builds the scheduler infrastructure, downloads the trace, and derives two traces in our proprietary format - one is 5-minute long (for testing), another is 1-hour long (same duration as in the paper). This step can take up to ~5 minutes.
2. Go to `scheduler/scripts` and run `bash benchmark-lse-all.sh ../azure-dataset/output/trace-5min.csv` to replay the shorter trace or `bash benchmark-lse-all.sh ../azure-dataset/output/trace-5min.csv` to replay the longer trace. The shorter trace is expected to run ~35 minutes (3 modes * 2 scenarios * 5 minutes + 5 minutes for setup/cooldown).

After the experiment is finished (and its results are written to `/tmp/lse_results`), you can generate the plots as in Figure 8 by running:

```
$ cd scheduler/plots
$ python plot-scheduling-latency.py
$ python plot-latency.py
# Open `scheduling-latency.pdf` and `latency.pdf` to see the results.
```

Even the plots obtained with the 5-minute trace should already show the same tendencies as the paper plots.
