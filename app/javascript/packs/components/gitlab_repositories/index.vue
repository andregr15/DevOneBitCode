<template>
  <div class="col m10 offset-m1 s10 offset-s1">
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
          <a :href="repository.web_url" class="custom-grey-text text-darken-1">{{repository.web_url}}</a>
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
              let gitlab = response.body.resource.filter(x => x.kind == 'gitlab');
              if (gitlab){
                let index = gitlab[0].url.lastIndexOf('/') + 1;
                let user = gitlab[0].url.substring(index);
                fetch(`https://gitlab.com/api/v4/users/${ user }/projects`)
                    .then(
                      response => (response.json()).then(data => this.repositories = data),
                      error => M.toast({
                        html: "Ocorreu um erro ao carregar os dados do gitlab",
                        classes: "red"
                      })
                    );
              }
            },
            error => M.toast({
              html: "Ocorreu um erro ao carregar os dados do gitlab",
              classes: "red"
            })
          );
    }
  }
</script>
