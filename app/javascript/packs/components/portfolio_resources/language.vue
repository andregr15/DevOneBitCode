<template>
  <div class="bloco-linguagem">
    <h4 class="block-title grey">Linguanges</h4>
    <div class="row">
      <div class="input-field col l5 m5 s12">
        <input type="text" id="language-title" class="font_20 custom-grey-text text-darken-1" 
                v-model="language.title" />
        <label for="language-title" class="font_20 custom-grey-text text-darken-1">Título</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <input type="number" class="font_20 custom-grey-text text-darken-1" id="language-percent" 
                v-model="language.percent" min="0" max="100" />
        <label for="language-percent" class="font_20 custom-grey-text text-darken-1">Porcentagem</label>
      </div>

      <div class="input-field col l3 m3 s6">
        <button class="btn" id="add-language" type="button" @click="submit()">Adicionar</button>
      </div>
    </div>

    <div v-for="language in languages" :key="language.title" class="row resource-list">
      <div class="col l12 m12 s12">
        <div class="row resource-item resource-language">
          <div class="col l5 m5 s5 center">{{ language.title }}</div>
          <div class="col l1 m1 s1 center">/</div>
          <div class="col l5 m5 s5 center">{{ language.percent }}</div>
          <div class="col l1 m1 s1">
            <a class="fa fa-times grey-text remove-language" @click="removeLanguage(language)"></a>
          </div>
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
        language: {},
        languages: []
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/languages')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.languages = (response.body.resource != null ) ? response.body.resource : [],
            error => M.toast({
              html: "Ocorreu um erro ao carregar as Linguagens",
              classes: "red"
            })
          );
    },

    methods: {
      submit() {
        this.$resource('/portfolios{/portfolioId}/languages')
            .save(
              { portfolioId: this.portfolioId },
              { language: this.language }
            ).then(
              response => this.languages.push(response.body.resource),
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      },

      removeLanguage(language) {
        this.$resource('/portfolios{/portfolioId}/languages{/id}')
            .remove({
              portfolioId: this.portfolioId,
              id: language.id
            }).then(
              response => {
                let indexToRemove = this.languages.indexOf(language);
                this.languages.splice(indexToRemove, 1);
              },
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      }
    }
  }
</script>
