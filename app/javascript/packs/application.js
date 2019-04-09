import Vue from 'vue';
import App from './app.vue';
import App1 from './app1.vue';
import VueResource from 'vue-resource';
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(VueResource);
Vue.use(TurbolinksAdapter);

let meta_element = document.getElementsByName('csrf-token')[0];
Vue.http.headers.common['X-CSRF-Token'] = meta_element.getAttribute('content');

document.addEventListener('turbolinks:load', () => {
  if(document.getElementById('portfolio-edit')) {
    const app = new Vue({
      el: '#portfolio-edit',
      render: h => h(App)
    })
  }

  if(document.getElementById('github-repos')) {
    const app = new Vue({
      el: '#github-repos',
      render: h => h(App1, {
        props:{
          portfolioId: document.querySelector("#github-repos").dataset.portfolioId
        }
      })
    })
  }
});