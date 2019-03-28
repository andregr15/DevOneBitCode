<template>
  <div class='bloco-social'>
    <h4 class="block-title grey">Redes Sociais</h4>
    <div class="row">
      <div class="input-field col xl12 l12 m12 s12">
        <select name="select-social-kind" id="select-social-kind" v-model="social.kind" class="browser-default">
          <option value="">Escolha um item</option>
          <option v-for="(value, key) in socialKinds" :value="key" :key="key">{{ value }}</option>
        </select>
      </div>

      <div class="input-field col l12 m12 s12">
        <input type="text" v-model="social.url" id="social-url" class="font_20 custom-grey-text text-darken-1" />
        <label for="social-url" class="font_20 custom-grey-text text-darken-1">URL</label>
      </div>

      <div class="input-field col l12 m12 s12">
        <button type="button" @click="submit" class="btn right" id="add-social">Adicionar</button>
      </div>
    </div>

    <div v-for="social in socials" :key="social.id" class="row resource-list">
      <div class="col l12 m12 s12">
        <div class="row resource-item resource-social">
          <div class="col l10 m10 s10 valign-wrapper">
            <img alt="socials picture" :src="`/socials/${social.kind}.png`" width="12%" />   
            <a :href="social.url" target="_blank">{{ relativePath(social.url) }}</a>
          </div>

          <div class="col l1 m1 s1">
            <a @click="removeSocial(social)" class="fa fa-times grey-text remove-social"></a>
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
        social: {},
        socials: [],
        socialKinds: {
          facebook: "Facebook",
          twitter: "Twitter",
          linkedin: "LinkedIn",
          github: "Github",
          instagram: "Instagram"
        }
      }
    },

    created() {
      this.$resource("/portfolios{/portfolioId}/socials")
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.socials = (response.body.resource != null) ? response.body.resource : [],
            error => M.toast({
              html: "Ocorreu um erro ao carregar as Redes Sociais",
              classes: "red"
            })
          )
    },

    methods: {
      relativePath(url) {
        let url_obj = new URL(url);
        return url_obj.pathname
      },

      submit() {
        this.$resource('/portfolios{/portfolioId}/socials')
            .save(
              { portfolioId: this.portfolioId },
              { social: this.social }
            ).then(
              response => {
                this.socials.push(response.body.resource);
                this.social = {};
              },
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      },

      removeSocial(social) {
        this.$resource('/portfolios{/portfolioId}/socials{/id}')
            .remove({
              portfolioId: this.portfolioId,
              id: social.id
            }).then(
              response => {
                let indexToRemove = this.socials.indexOf(social);
                this.socials.splice(indexToRemove, 1);
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