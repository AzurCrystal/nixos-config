final: prev:
{
  sway-unwrapped = prev.sway-unwrapped.overrideAttrs (o: {
    patches = o.patches or [ ] ++ [
      ./0001-text_input-Implement-input-method-popups.patch
    ];
  });
}
