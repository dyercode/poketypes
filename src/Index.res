switch ReactDOM.querySelector("#react-app") {
| Some(root) => ReactDOM.render(<App />, root)
| None => ()
}
