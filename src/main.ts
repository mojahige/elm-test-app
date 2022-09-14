import { Elm } from "./elm/Main.elm";

function main(target: Element) {
  return Elm.Main?.init({
    node: target,
    flags: "🐶",
  });
}

function subscribe(app: App) {
  app.ports.confirm?.subscribe((message: string) => {
    const answer = confirm(message);

    app.ports.receiveAnswer?.send(answer);
  });
}

export function start() {
  const target = document.querySelector("#app");

  if (!target) {
    return;
  }

  const app = main(target);

  app && subscribe(app);
}
