---
description: Investigate a problem across repositories
allowed-tools:
  - Bash(cat *)
  - Bash(cd *)
  - Bash(fd *)
  - Bash(find *)
  - Bash(gh api *)
  - Bash(gh issue view *)
  - Bash(gh pr diff *)
  - Bash(gh pr list *)
  - Bash(gh pr view *)
  - Bash(gh search *)
  - Bash(git log *)
  - Bash(git show *)
  - Bash(grep *)
  - Bash(head *)
  - Bash(kubectl get *)
  - Bash(kustomize *)
  - Bash(ls *)
  - Bash(mkdir *)
  - Bash(pwd *)
  - Bash(rg *)
  - Bash(wc *)
  - Glob
  - Grep
  - Read
  - WebSearch
---

# Investigate across Application and Infrastructure Repositories

You are to investigate a problem by inspecting several repositories.

## Investigation Process

### Step 1: Understand the problem
Read $ARGUMENT to understand what the user is asking.

### Step 2: Gather symptoms
Before forming any hypothesis, collect the actual symptoms — error messages, alerts, user reports, and observable behavior. Do NOT theorize before seeing the actual failure mode.
- Search for incident channels (`#incident-*`) in Slack
- Search for alert notifications in Slack
- Check Datadog monitor alerts
- Find actual error logs, curl outputs, stack traces, or screenshots from the report
The concrete symptoms (e.g. "Connection timed out to 52.x.x.x:443") determine the direction of investigation.

### Step 3: Form hypotheses
Based on the symptoms, list all plausible hypotheses that could explain the observed behavior. Consider multiple layers: DNS, network/security groups, application errors, configuration drift, deployment issues, etc.

### Step 4: Verify each hypothesis
For each hypothesis, gather evidence to confirm or reject it. Use the following sources:
- Local repositories. All repositories are stored under the same directory as the one the user is in. Here is a list of a part of the repositories:
  - k8s-service-manifests: Stores Kubernetes manifests defining resources of each microservice
  - k8s-infra-manifests: Stores Kubernetes manifests defining the cluster
  - services-terraform: Stores Terraform configuration defining infrastructures other than Kubernetes
  - bpd_repos: Stores all repositories managed by BPD teams
- Code in GitHub in `moneyforward` organization using `gh search repo` or `gh search code`. Always check the remote main branch (`gh api repos/.../contents/...`) rather than relying on a potentially stale local checkout.
- PR diffs and checks using `gh pr diff` or `gh pr checks`
- Messages in Slack using MCP
- Documents in Backstage using MCP
- Datadog metrics or logs using MCP
- Local documents in Obsidian Vault

When a hypothesis is rejected by evidence, explicitly state why and move to the next one. Do not present a hypothesis as a conclusion before verifying it with data.

### Step 5: Repeat until conclusion
Repeat steps 3–4 until all plausible hypotheses have been verified or rejected. Continue investigating until a root cause is established with supporting evidence. If you reach a dead end, ask the user for more information or context before proceeding.

## Services with dedicated infra repositories
Some services have their own infrastructure repositories separate from k8s-service-manifests and services-terraform. When investigating these services, check the dedicated repos for CTO Garage-era K8s manifests, ALB/CLB definitions, and security group configurations.
- carry: [carry-k8s](https://github.com/moneyforward/carry-k8s)
- flair: [flair_k8s](https://github.com/moneyforward/flair_k8s), [flair_web_k8s](https://github.com/moneyforward/flair_web_k8s)
- qpie: [qpie_infra](https://github.com/moneyforward/qpie_infra) (not in k8s-service-manifests)
- racer: [racer_k8s](https://github.com/moneyforward/racer_k8s)

## Guideline
- Put links to code on GitHub, Slack, or any other external sources
- Show Datadog metrics query every time you refer to them
- Use `datadog_url_generator` MCP when you attach a link to Datadog metrics
- Proactively search previous trials or discussions in documents or code
