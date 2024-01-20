{ ... }:

/* On Postgresql version >= 15, roles cannot automatically create new TABLES.
 * Should mannually grant permissions in the specific DATABASE by superusers.
 * Refer:
 * https://www.cybertec-postgresql.com/en/error-permission-denied-schema-public/
*/

{
  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "vaultwarden";
      }
    ];
    ensureDatabases = [
      "vaultwarden"
    ];
    identMap =
      ''
        superuser_map root      postgres
        superuser_map postgres  postgres
        superuser_map /^(.*)$   \1
      '';
    authentication =
      ''
        local sameuser  all peer  map=superuser_map
      '';
  };
}
