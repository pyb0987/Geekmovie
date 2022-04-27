function throttle(cb, delay){
	  let timer = null;
  return function (...args) {
    if (timer === null) {
      timer = setTimeout(() => {
        cb.apply(this, args);
        timer = null;
      }, delay);
    }
  };
}