# hello-source

This is a hello-world page for the code-promotion demo. Merges to `main` ring a doorbell on the destination repository, which pulls, scans, fast-forwards and deploys. See the demo kit's README.md and SETUP.md.

To trigger the demo's simulated Veracode finding, add the marker `DEMO-FINDING` anywhere in `app/index.html`. The scan blocks the promotion, and the destination's `main` does not move.
