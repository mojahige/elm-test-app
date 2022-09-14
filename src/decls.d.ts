type InitArgs = {
  node: ReturnType<typeof document.querySelector>;
  flags?: unknown;
};
type App = {
  ports: {
    [key: string]: {
      subscribe: (args: any) => void;
      send: (args: any) => void;
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
