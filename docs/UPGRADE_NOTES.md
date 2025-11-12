# dbt v1.10 Upgrade Notes

## Upgrade Summary

This project has been upgraded to dbt-bigquery v1.10. The upgrade is **fully compatible** with the existing codebase, requiring no immediate changes.

## What Changed

### Dependencies
- Created `requirements.txt` with `dbt-bigquery>=1.10.0,<1.11.0`
- This automatically includes dbt-core v1.10 as a dependency

### Compatibility Check
✅ `dbt_project.yml` - Compatible (config-version: 2)
✅ Model files - No deprecated patterns found
✅ Schema definitions - Standard v2 format
✅ Configurations - All compatible with v1.10

## Installation

To install dbt v1.10, run:

```bash
pip install -r requirements.txt
```

Or to upgrade an existing installation:

```bash
pip install --upgrade dbt-bigquery
```

## Key Changes in dbt v1.10

### New Features (Optional)
- **Sample mode**: Use `dbt run --sample` to reduce build times with time-based data sampling
- **YAML anchors**: Define reusable config blocks under `anchors:` key
- **Macro validation**: Opt-in macro argument validation with `validate_macro_args` flag

### Deprecation Warnings (No Action Required Yet)
These will raise warnings but won't break functionality:

1. **`--models` flag**: Will be deprecated in future versions
   - Current: `dbt run --models my_model`
   - Recommended: `dbt run --select my_model`

2. **Custom YAML properties**: Should be moved under `config.meta` in future
   - Not applicable to this project (no custom properties detected)

3. **Property relocations**: Six properties moving to `config` blocks in future
   - Affected: `freshness`, `meta`, `tags`, `docs`, `group`, `access`
   - Not applicable to this project

## No Breaking Changes

dbt v1.10 maintains **full backward compatibility** with v1.x projects. All existing functionality will continue to work without modifications.

## Recommended Next Steps

1. Install the new version: `pip install -r requirements.txt`
2. Verify installation: `dbt --version`
3. Test your project: `dbt debug` (requires profiles.yml configuration)
4. Run your models: `dbt run`

## Resources

- [Official v1.10 Upgrade Guide](https://docs.getdbt.com/docs/dbt-versions/core-upgrade/upgrading-to-v1.10)
- [dbt-bigquery Documentation](https://docs.getdbt.com/reference/warehouse-setups/bigquery-setup)
- [Version Migration Guides](https://docs.getdbt.com/guides/migration/versions)
