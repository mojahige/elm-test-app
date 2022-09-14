type InitArgs = {
  node: ReturnType<typeof document.querySelector>;
  flags?: unknown;
};
type App = {
  ports: {
    [key: string]: {
      /* eslint-disable @typescript-eslint/no-explicit-any */
      subscribe: (args: any) => void;
      send: (args: any) => void;
      /* eslint-enable @typescript-eslint/no-explicit-any */
    };
  };
};

declare module "*.elm" {
  export const Elm: {
    [key: string]: {
      init: (args: InitArgs) => App;
    };
  };
}
