---
description: Verify compliance with Widget Separation Rules
---

1. Read the widget separation rules from `.agent/rules/widget_separation_rules.md`.
2. View the target file (use the currently active file if available, or ask the user).
3. Analyze the code for the following violations:
   - **Private Widget Classes**: Are there `_WidgetName` classes defined in the file? They should be moved to separate files in `widgets/`.
   - **Long Build Method**: Is the `build` method longer than 50-100 lines? It should be broken down into `_buildSectionName()` helper methods.
   - **Hardcoded Values**: Are there hardcoded colors or text styles? They should use `AppColors` and `AppTextStyles`.
4. If violations are found, report them and propose a refactoring plan.
5. If requested, proceed with refactoring.
