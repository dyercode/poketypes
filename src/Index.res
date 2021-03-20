switch ReactDOM.querySelector("#react-app") {
| Some(root) => ReactDOM.render(<App selecteds=[None, None, None, None, None, None] />, root)
| None => ()
}
