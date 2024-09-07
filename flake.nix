{
  outputs = { self }: {
    templates.default = {
      path = ./template;
      description = "Basic NixOS systems flake template";
    };
  };
}
