import "./style.css";
import { Elm } from "./elm/Main.elm";

const app = Elm.Main!.init({
  node: document.querySelector("#app"),
  flags: "🐶",
});

app.ports.confirm.subscribe((message: string) => {
  const answer = confirm(message);

  app.ports.receiveAnswer.send(answer);
});
