# Squid Proxy k8s installation

This will setup a [squid proxy](http://www.squid-cache.org/) on a k8s server,
used to 'simulate' hardened setups in which the env0 agent is behind a proxy server.
All outgoing traffic from the agent must go through the proxy.

### Installing squid-proxy

- Apply the `squid-proxy.yaml` file.

### Network Policy

- The `network-policy.yaml` create a K8S network policy that will limit all traffic in a given namespace to go through the proxy.
- Requires [calico](https://docs.aws.amazon.com/eks/latest/userguide/calico.html) to be installed - the vanilla k8s cluster doesn't enforce network policies.
- Don't install without a specific namespace, it might affect core k8s services.

### Testing

- `curl https://google.com` should not work
- `curl https://google.com -x {proxy ip}:3128` should work

### Updating the agent

- The agent should be installed with these values

```
"httpProxy": "http://squid-proxy-service.squid-proxy.svc.cluster.local:80"
"httpsProxy": "http://squid-proxy-service.squid-proxy.svc.cluster.local:80"
"noProxy": "{K8S ApiService IP/DNS}"
```
