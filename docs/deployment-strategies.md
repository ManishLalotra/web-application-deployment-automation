# Modern Deployment Strategies

## 1. Symlink Atomic Switching
By pointing Nginx / web servers to a `current` symlink and updating the symlink via an atomic rename (`mv -Tf`), requests are instantly switched to the new release directory with zero dropped packets.

## 2. Blue-Green Container Deployment
Runs two identical container environments (Blue and Green). New releases deploy to the idle tier, undergo synthetic health verification, and traffic switches gracefully via Nginx reverse proxy reload.
