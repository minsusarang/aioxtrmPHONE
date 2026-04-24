const _console_log_org   = console.log;
const _console_warn_org  = console.warn;
const _console_error_org = console.error;
const msecOfset = (new Date()).getTimezoneOffset()*60*1000;
let loggers = null;

function koTimeMS(){
  return (new Date(Date.now() - msecOfset)).toISOString().replace('T',' ').replace('Z','');
}

/* USAGE:
    let agtInfo = new AgtLogger(user_id,'http://211.47.160.201:5009','info','db');
    agtInfo.log('테스트');
*/
function AgtLogger(user_id, apiBase, logNameSpace = 'info', logTo = 'file'){
  this.user_id = user_id;
  this.lns   = logNameSpace;
  this.url   = `${apiBase}/agtLog`;
  this.lns   = logNameSpace;
  this.logTo = logTo;
}

/*
  SERVER SIDE CONTROL: 
  curl "http://localhost:5001/fn/disableAgtLog/1000" 
*/
function disableAgtLog(){
  console.log = _console_log_org;   
  console.warn = _console_warn_org;  
  console.error = _console_error_org; 
 }
 

AgtLogger.prototype.log = async function(){
  let args = Array.from(arguments);

  let ss = args.reduce((s,v)=>(s+'|'+((typeof(v)==='object')?JSON.stringify(v):v)),'');



  try{
    await fetch(this.url, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: 'POST',
      body: JSON.stringify({
        user_id: this.user_id,
        lns: this.lns,
        logTo: this.logTo,
        sentAt: koTimeMS(),
        logData: encodeURIComponent(ss)
      })
    })
  }catch(err){
//    disableAgtLog();
    console.log(`[${koTimeMS()}] AgtLogger: ${err.message}`);
  }
}

function _enableAgtLog(loggers){
// console.log = loggers.log;   
 console.warn = loggers.warn;
 console.error = loggers.error;
}

/*
  SERVER SIDE CONTROL: 
  curl "http://localhost:5001/fn/enableAgtLog/1000?args=1000"
*/    
function enableAgtLog(user_id,protocol,host,port){
 // let urlBase = `${protocol||location.protocol}//${host||location.hostname}:${port||5009}`;
  let urlBase = `http://${window.gProxy}:5009`;
  loggers = loggers || {
    log: (new AgtLogger(user_id,urlBase,'info','db')),
    warn: (new AgtLogger(user_id,urlBase,'warn','db')),
    error: (new AgtLogger(user_id,urlBase,'error','db'))
  };
  _enableAgtLog({
    log: loggers.log.log.bind(loggers.log),
    warn: loggers.warn.log.bind(loggers.warn),
    error: loggers.error.log.bind(loggers.error)
  });
}

