<template>
  <div class="col m10 offset-m1 s10 offset-s1">
    <div v-if="this.repositories.length == 0">
      <p class="custom-grey-text text-darken-1">Sem informações do github</p>
    </div>
    <div v-for="repository in this.repositories" :key="repository.name">
      <div class="row custom-space">
        <div class="col m4 s12 custom-blue">
          <div class="left box">
            <span class="title white-text">
              {{ repository.name }}
            </span>
          </div>
        </div>

        <div class="col m8 s12">
          <a :href="repository.html_url" class="custom-grey-text text-darken-1">{{repository.html_url}}</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['portfolioId'],

    data() {
      return {
        repositories: []
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/socials')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => {
              let github = response.body.resource.filter(x => x.kind == 'github');
              if (github){
                let index = github[0].url.lastIndexOf('/') + 1;
                let user = github[0].url.substring(index);
                fetch(`https://api.github.com/users/${ user }/repos`)
                    .then(
                      response => (response.json()).then(data => this.repositories = data),
                      error => M.toast({
                        html: "Ocorreu um erro ao carregar os dados do github",
                        classes: "red"
                      })
                    );
              }
            },
            error => M.toast({
              html: "Ocorreu um erro ao carregar os dados do github",
              classes: "red"
            })
          );
    }
  }
</script>
