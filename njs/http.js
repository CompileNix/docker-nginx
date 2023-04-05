// vim: sw=2 et

async function date(r) {
  r.return(200, new Date() + '\n')
}

async function hello(r) {
  r.return(200, 'Hello world from nginx njs!\n')
}

async function version(r) {
  r.return(200, 'njs v' + njs.version + '\n')
}

export default {
  date,
  hello,
  version,
}

