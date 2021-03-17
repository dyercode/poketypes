switch ReactDOM.querySelector("#react-app") {
| Some(rootElement) =>
  let root = ReactDOM.Client.createRoot(rootElement)
  ReactDOM.Client.Root.render(root, <App />)
| None => ()
}
