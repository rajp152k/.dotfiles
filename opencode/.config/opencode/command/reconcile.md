---
description: Reconcile current state towards a desired final state
agent: build
---

Reconcile towards the desired state: $ARGUMENTS

Steps:
1. Parse the desired final state from the description
2. Analyze the current state (files, configs, running services, etc.)
3. Identify the delta between current and desired
4. Create a plan of actions to bridge the gap
5. Execute actions incrementally, verifying after each step
6. Report final state and any remaining discrepancies

If monitoring is requested:
- Set up a watch loop to detect drift
- Take corrective actions when state diverges
- Report changes made

This is a declarative reconciliation pattern — describe *what* you want, not *how* to get there.
