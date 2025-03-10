require 'rails_helper'

RSpec.describe 'KeyStage', type: :request do
  describe 'list Key Stages' do
    let!(:published_key_stage) { create(:published_key_stage) }

    it 'returns published key stages' do
      post '/graphql', params: {
        query: <<~GQL
          {
            keyStages
              {
                id
                title
                shortTitle
                level
                ages
                years
                description
                curriculumMaps {
                  id
                  name
                  file
                }
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          keyStages: [{
            id: published_key_stage.id,
            title: published_key_stage.title,
            shortTitle: published_key_stage.short_title,
            level: published_key_stage.level,
            ages: published_key_stage.ages,
            years: published_key_stage.years,
            description: published_key_stage.description,
            curriculumMaps: published_key_stage.curriculum_maps
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end

    it 'only returns published year groups' do
      published_year_group = create(
        :published_year_group,
        key_stage: published_key_stage,
        year_number: '999'
      )
      create(:year_group, key_stage: published_key_stage)

      post '/graphql', params: {
        query: <<~GQL
          {
            keyStages
              {
                id
                title
                slug
                shortTitle
                level
                ages
                description
                yearGroups {
                  id
                  yearNumber
                }
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          keyStages: [{
            id: published_key_stage.id,
            title: published_key_stage.title,
            slug: published_key_stage.slug,
            shortTitle: published_key_stage.short_title,
            level: published_key_stage.level,
            ages: published_key_stage.ages,
            description: published_key_stage.description,
            yearGroups: [{
              id: published_year_group.id,
              yearNumber: published_year_group.year_number
            }]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
