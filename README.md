# web-application-deployment-automation

> Blue-Green and Zero-Downtime atomic deployment orchestration engine for Linux VPS and Docker environments.

## Features
- **Atomic Symlink Deployment**: Capistrano/Envoy-style release versioning (`releases/<timestamp>` -> `current`).
- **Blue-Green Container Automation**: Seamless traffic cutover via port toggling and Nginx reload.
- **One-Command Instant Rollback**: Atomic reversion to prior stable release.
- **Automated Retention**: Pruning historical releases to prevent storage leaks.

## Usage
```bash
./scripts/zero-downtime-deploy.sh
./scripts/blue-green-docker.sh
./scripts/rollback.sh
```

## Author
**Manish Lalotra**  
Full Stack Developer & DevOps Engineer  
*Full Stack Developer | DevOps Engineer | Cloud & Infrastructure Engineer*

## License
MIT License. See [LICENSE](LICENSE) for details.
