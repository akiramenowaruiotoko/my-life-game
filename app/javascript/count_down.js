const countDown = () => {

      const targetDate = document.getElementsByClassName('taget-date');

      const targetCount = targetDate.length;
      
      for (let i = 0; i < targetCount; i++ ){
        
        const addRmainingTime = document.getElementsByClassName("remaining-time");
        addRmainingTime[i].innerHTML =  targetDate[i].textContent;

        console.log(addRmainingTime);
      };
      
};

window.addEventListener("load", countDown);