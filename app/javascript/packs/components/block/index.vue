<template>
<div class="row">
  <div class="col m10 offset-m1 s12">
    <div class="row">
      <div class="col s12">
        <h5 class="custom-grey-text page-title">Cards do Portfólio</h5>
      </div>

      <div class="col l4 m4 s12">
        <div class="card-panel" v-for='block in leftBlocks' :key='block.id'>
          <a class="fa fa-times grey-text right" @click='removeBlock(block)'></a>
          <component :is='block.kind' :portfolioId='portfolioId' :blockId='block.id'></component>
        </div>

        <div class="card-panel center">
          <img src='/assets/add_portfolio.png' id='add-left-block' @click="openModalToAdd('left')" />
        </div>
      </div>

      <div class="col l8 m8 s12">
        <div class="card-panel" v-for='block in rightBlocks' :key='block.id'>
          <a href="" class="fa fa-times grey-text right" @click='removeBlock(block)'></a>
          <component :is='block.kind' :portfolioId='portfolioId' :blockId='block.id'></component>
        </div>

        <div class="card-panel center">
          <img src='/assets/add_portfolio.png' id='add-right-block' @click="openModalToAdd('right')" />
        </div>
      </div>

      <div class="modal" id='add-block-modal'>
        <div class="modal-content">
          <h4>Adicionar Novo Bloco</h4>
          <div class="row">
            <div class="input-field col xl12 l12 m12 s12">
              <select id="select-block-kind" class="browser-default" v-model='blockToAdd.kind'>
                <option value="">Escolha um tipo</option>
                <option v-for="(value, key) in blockKinds" :value="key" v-bind:key="key">{{ value }}</option>
              </select>
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <a class="modal-close btn custom-grey">Cancelar</a>
          <a class="btn custom-green" id="confirm-add-block" @click="addBlock(blockToAdd)">Adicionar</a>
        </div>
      </div>

    </div>

  </div>

</div>
</template>

<script>
  import Profile from '../portfolio_resources/profile';
  import Education from '../portfolio_resources/education';
  import AdditionalInformation from '../portfolio_resources/additional_information';
  import About from '../portfolio_resources/about';
  import Contact from '../portfolio_resources/contact';
  import Experience from '../portfolio_resources/experience';
  import Hobby from '../portfolio_resources/hobby';
  import Language from '../portfolio_resources/language';
  import Skill from '../portfolio_resources/skill';
  import Social from '../portfolio_resources/social';
  import ContactForm from '../portfolio_resources/contact_form';

  export default {
    components: {
      Profile,
      Education,
      'additional_information': AdditionalInformation,
      About,
      Contact,
      Experience,
      Hobby,
      Language,
      Skill,
      Social,
      'contact_form': ContactForm
    },

    data() {
      return {
        portfolioId: "",
        blocks: [],
        leftBlocks: [],
        rightBlocks: [],
        blockToAdd: { kind: "" },
        blockKinds: {},
        leftKinds: {
          profile: "Perfil",
          about: "Sobre mim",
          social: "Social",
          additional_information: "Informações Adicionais"
        },
        rightKinds: {
          experience: "Experiência",
          education: "Educação",
          skill: "Habilidade",
          hobby: "Hobby",
          language: "Linguagem",
          additional_information: "Informações Adicionais",
          contact_form: "Formulário de contato"
        }
      }
    },

    watch: {
      blocks() {
        this.leftBlocks = this.blocks.filter(
          block => block.side == "left"
        );

        this.rightBlocks = this.blocks.filter(
          block => block.side == "right"
        );
      }
    },

    created() {
      this.portfolioId = $("#portfolio-edit").data("portfolio");
    },

    mounted() {
      let modal_element = document.getElementById("add-block-modal");
      this.modalInstance = M.Modal.init(modal_element);
      this.$resource('/portfolios{/portfolioId}/blocks')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.blocks = response.body.blocks,
            error => M.toast({
              html: 'Erro on trying to get Blocks',
              classes: 'red'
            })
          );
    },

    methods: {
      openModalToAdd(side) {
        this.blockToAdd.side = side;
        this.blockKinds = this[`${side}Kinds`];
        this.modalInstance.open();
      },

      addBlock() {
        this.$resource('/portfolios{/portfolioId}/blocks')
            .save(
              { portfolioId: this.portfolioId },
              { block: this.blockToAdd }
            )
            .then(
              response => {
                this.blocks.push(response.body.block);
                this.modalInstance.close();
                this.blockToAdd = {};
              },
              errors => errors.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      },

      removeBlock(blockToRemove) {
        this.$resource('/portfolios{/portfolioId}/blocks{/id}')
            .remove({ 
              portfolioId: blockToRemove.portfolio_id,
              id: blockToRemove.id
            })
            .then(
              response => {
                let indexToRemove = this.blocks.indexOf(blockToRemove);
                this.blocs.splice(indexToRemove, 1);
              },
              errors => errors.body.errors.forEach(
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
