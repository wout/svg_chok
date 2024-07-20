document.addEventListener('DOMContentLoaded', () => {
  // Watch changes for specific files
  document.querySelectorAll('[\\@sync]').forEach((el) => {
    openWebsocket(el)
  })

  // Navigate without reloading the page
  document.body.addEventListener('click', (e) => {
    if (e.target.tagName === 'A') {
      e.preventDefault()
      fetchBody(e.target.getAttribute('href'))
    }
  })

  // Watch browser navitationg to update history
  window.onpopstate = () => fetchBody(location.href)
})

function openWebsocket(el) {
  const protocol = location.protocol === 'https:' ? 'wss' : 'ws'
  const ws = new WebSocket(protocol + '://' + location.host + '/watcher')
  ws.onopen = () => console.log('SvgChok: connected to watcher')
  ws.onmessage = (e) => handleSync(el.getAttribute('@sync'), JSON.parse(e.data))
  window.onbeforeunload = () => {
    ws.onclose = () => console.log('SvgChok: disconnecting from watcher')
    ws.close()
  }
}

function handleSync(file, { files }) {
  if (files.length == 0) return
  if (file != '' && !files?.includes(file)) return

  fetchBody(location.href)
}

function fetchBody(href) {
  fetch(href)
    .then((res) => res.text())
    .then((html) => replaceBody(html))
    .then(() => history.pushState({}, '', href))
}

function replaceBody(html) {
  const doc = new DOMParser().parseFromString(html, 'text/html')
  document.body.innerHTML = doc.querySelector('body').innerHTML
}
