type InitArgs = {
  node: ReturnType<typeof document.querySelector>;
  flags?: unknown;
};

type InitReturn = {
  ports: any;
};

declare module "*.elm" {
  export const Elm: {
    [key: string]: {
      init: (args: InitArgs) => InitReturn;
    };
  };
}
