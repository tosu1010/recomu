function addToNewUrl() {
  let path = location.pathname;
  let pattern = /^.*\/new.*$/

  if (path.match(pattern)) return;

  history.replaceState('', '', `${ path }/new`)
}