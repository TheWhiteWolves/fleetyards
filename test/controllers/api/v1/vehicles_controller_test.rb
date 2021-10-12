# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class VehiclesControllerTest < ActionController::TestCase
      setup do
        @request.headers['Accept'] = Mime[:json]
        @request.headers['Content-Type'] = Mime[:json].to_s
      end

      tests Api::V1::VehiclesController

      describe 'without session' do
        it 'should render 403 for index' do
          get :index

          assert_response :unauthorized
          json = JSON.parse response.body
          assert_equal 'unauthorized', json['code']
        end

        it 'should render 403 for quick-stats' do
          get :quick_stats

          assert_response :unauthorized
          json = JSON.parse response.body
          assert_equal 'unauthorized', json['code']
        end

        it 'should render 200 for public quick-stats' do
          get :public_quick_stats, params: { username: 'data' }

          assert_response :ok
          json = JSON.parse response.body

          expected = {
            'total' => 2,
            'classifications' => [{
              'name' => 'explorer',
              'label' => 'Explorer',
              'count' => 1
            }, {
              'name' => 'multi_role',
              'label' => 'Multi role',
              'count' => 1
            }],
            'groups' => []
          }
          assert_equal expected, json
        end

        it 'should render 403 for hangar-items' do
          get :hangar_items

          assert_response :unauthorized
          json = JSON.parse response.body
          assert_equal 'unauthorized', json['code']
        end
      end

      describe 'with session' do
        let(:data) { users :data }
        let(:explorer) { data.vehicles.includes(:model).find_by(models: { name: '600i' }) }
        let(:enterprise) { data.vehicles.includes(:model).find_by(models: { name: 'Andromeda' }) }

        before do
          sign_in data
        end

        it 'should return list for index' do
          get :index

          assert_response :ok
          json = JSON.parse response.body

          expected = [{
            'id' => explorer.id,
            'name' => '',
            'serial' => nil,
            'purchased' => true,
            'loaner' => false,
            'flagship' => false,
            'public' => true,
            'nameVisible' => false,
            'saleNotify' => false,
            'alternativeNames' => [],
            'model' => {
              'id' => explorer.model_id,
              'name' => '600i',
              'rsiName' => nil,
              'slug' => '600i',
              'rsiSlug' => nil,
              'description' => nil,
              'length' => 20.0,
              'beam' => 0.0,
              'height' => 0.0,
              'mass' => 0.0,
              'cargo' => 40.0,
              'cargoLabel' => '600i (40 SCU)',
              'hydrogenFuelTankSize' => nil,
              'quantumFuelTankSize' => nil,
              'minCrew' => 2,
              'maxCrew' => 5,
              'scmSpeed' => nil,
              'afterburnerSpeed' => nil,
              'groundSpeed' => nil,
              'afterburnerGroundSpeed' => nil,
              'pitchMax' => nil,
              'yawMax' => nil,
              'rollMax' => nil,
              'xaxisAcceleration' => nil,
              'yaxisAcceleration' => nil,
              'zaxisAcceleration' => nil,
              'size' => nil,
              'sizeLabel' => nil,
              'storeImage' => explorer.model.store_image.url,
              'storeImageLarge' => explorer.model.store_image.large.url,
              'storeImageMedium' => explorer.model.store_image.medium.url,
              'storeImageSmall' => explorer.model.store_image.small.url,
              'fleetchartImage' => nil,
              'brochure' => nil,
              'holo' => nil,
              'holoColored' => false,
              'storeUrl' => 'https://robertsspaceindustries.com',
              'salesPageUrl' => nil,
              'price' => nil,
              'pledgePrice' => nil,
              'lastPledgePrice' => 400.0,
              'onSale' => false,
              'productionStatus' => nil,
              'productionNote' => nil,
              'classification' => 'explorer',
              'classificationLabel' => 'Explorer',
              'focus' => nil,
              'rsiId' => 14_101,
              'hasImages' => false,
              'hasVideos' => false,
              'hasModules' => false,
              'hasUpgrades' => false,
              'hasPaints' => false,
              'lastUpdatedAt' => explorer.model.last_updated_at&.utc&.iso8601,
              'lastUpdatedAtLabel' => (I18n.l(explorer.model.last_updated_at&.utc, format: :label) if explorer.model.last_updated_at.present?),
              'soldAt' => [],
              'boughtAt' => [],
              'listedAt' => [{
                'id' => 'e2befa3a-fe27-53f7-9405-268d23b2dfb7',
                'name' => '600i',
                'slug' => '600i',
                'storeImage' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageLarge' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageMedium' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageSmall' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'category' => 'model',
                'subCategory' => 'explorer',
                'subCategoryLabel' => 'Explorer',
                'description' => nil,
                'pricePerUnit' => false,
                'sellPrice' => nil,
                'averageSellPrice' => nil,
                'buyPrice' => nil,
                'averageBuyPrice' => nil,
                'rentalPrice1Day' => nil,
                'averageRentalPrice1Day' => nil,
                'rentalPrice3Days' => nil,
                'averageRentalPrice3Days' => nil,
                'rentalPrice7Days' => nil,
                'averageRentalPrice7Days' => nil,
                'rentalPrice30Days' => nil,
                'averageRentalPrice30Days' => nil,
                'locationLabel' => 'sold at Dumpers Depot on Port Olisar',
                'confirmed' => true,
                'commodityItemType' => 'Model',
                'commodityItemId' => '2e4b73e2-52bf-5b4c-8246-fb40ba397b38',
                'shop' => {
                  'id' => 'fd71143a-7403-50e3-a5c0-32f62ab537b6',
                  'name' => 'Dumpers Depot',
                  'slug' => 'dumpers-depot',
                  'type' => 'components',
                  'typeLabel' => 'Components Store',
                  'stationLabel' => 'at Port Olisar',
                  'location' => nil,
                  'locationLabel' => 'at Port Olisar in orbit around Crusader',
                  'rental' => false,
                  'buying' => false,
                  'selling' => false,
                  'storeImage' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageLarge' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageMedium' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageSmall' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'refineryTerminal' => nil,
                  'station' => {
                    'name' => 'Port Olisar',
                    'slug' => 'port-olisar'
                  }
                }
              }, {
                'id' => '46f72ce4-81f1-50d5-8428-5587ef23c320',
                'name' => '600i',
                'slug' => '600i',
                'storeImage' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageLarge' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageMedium' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageSmall' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'category' => 'model',
                'subCategory' => 'explorer',
                'subCategoryLabel' => 'Explorer',
                'description' => nil,
                'pricePerUnit' => false,
                'sellPrice' => nil,
                'averageSellPrice' => nil,
                'buyPrice' => nil,
                'averageBuyPrice' => nil,
                'rentalPrice1Day' => nil,
                'averageRentalPrice1Day' => nil,
                'rentalPrice3Days' => nil,
                'averageRentalPrice3Days' => nil,
                'rentalPrice7Days' => nil,
                'averageRentalPrice7Days' => nil,
                'rentalPrice30Days' => nil,
                'averageRentalPrice30Days' => nil,
                'locationLabel' => 'sold at New Deal on Port Olisar',
                'confirmed' => true,
                'commodityItemType' => 'Model',
                'commodityItemId' => '2e4b73e2-52bf-5b4c-8246-fb40ba397b38',
                'shop' => {
                  'id' => 'df2c9942-135d-5cbc-81d6-e1c14b6298bd',
                  'name' => 'New Deal',
                  'slug' => 'new-deal',
                  'type' => 'ships',
                  'typeLabel' => 'Ship Store',
                  'stationLabel' => 'at Port Olisar',
                  'location' => nil,
                  'locationLabel' => 'at Port Olisar in orbit around Crusader',
                  'rental' => false,
                  'buying' => false,
                  'selling' => false,
                  'storeImage' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageLarge' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageMedium' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageSmall' =>
                          'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'refineryTerminal' => nil,
                  'station' => {
                    'name' => 'Port Olisar',
                    'slug' => 'port-olisar'
                  }
                }
              }],
              'rentalAt' => [],
              'manufacturer' => {
                'name' => 'Origin',
                'slug' => 'origin',
                'code' => nil,
                'logo' => nil
              },
              'loaners' => [{
                'slug' => 'ptv',
                'name' => 'PTV'
              }],
              'createdAt' => explorer.model.created_at.utc.iso8601,
              'updatedAt' => explorer.model.updated_at.utc.iso8601
            },
            'paint' => nil,
            'upgrade' => nil,
            'hangarGroupIds' => explorer.hangar_group_ids,
            'hangarGroups' => explorer.hangar_groups.map do |hangar_group|
              {
                'id' => hangar_group.id,
                'slug' => hangar_group.slug,
                'name' => hangar_group.name,
                'color' => hangar_group.color
              }
            end,
            'modelModuleIds' => explorer.model_module_ids,
            'modelUpgradeIds' => explorer.model_upgrade_ids,
            'createdAt' => explorer.created_at.utc.iso8601,
            'updatedAt' => explorer.updated_at.utc.iso8601
          }, {
            'id' => enterprise.id,
            'name' => 'Enterprise',
            'serial' => nil,
            'purchased' => true,
            'loaner' => false,
            'flagship' => false,
            'public' => true,
            'nameVisible' => false,
            'saleNotify' => false,
            'alternativeNames' => [],
            'model' => {
              'id' => enterprise.model.id,
              'name' => 'Andromeda',
              'rsiName' => nil,
              'slug' => 'andromeda',
              'rsiSlug' => nil,
              'description' => nil,
              'length' => 61.2,
              'beam' => 10.2,
              'height' => 10.2,
              'mass' => 1000.02,
              'cargo' => 90.0,
              'cargoLabel' => 'Andromeda (90 SCU)',
              'hydrogenFuelTankSize' => nil,
              'quantumFuelTankSize' => nil,
              'minCrew' => 3,
              'maxCrew' => 5,
              'scmSpeed' => nil,
              'afterburnerSpeed' => nil,
              'groundSpeed' => nil,
              'afterburnerGroundSpeed' => nil,
              'pitchMax' => nil,
              'yawMax' => nil,
              'rollMax' => nil,
              'xaxisAcceleration' => nil,
              'yaxisAcceleration' => nil,
              'zaxisAcceleration' => nil,
              'size' => nil,
              'sizeLabel' => nil,
              'storeImage' => enterprise.model.store_image.url,
              'storeImageLarge' => enterprise.model.store_image.large.url,
              'storeImageMedium' => enterprise.model.store_image.medium.url,
              'storeImageSmall' => enterprise.model.store_image.small.url,
              'fleetchartImage' => nil,
              'brochure' => nil,
              'holo' => nil,
              'holoColored' => false,
              'storeUrl' => 'https://robertsspaceindustries.com',
              'salesPageUrl' => nil,
              'price' => nil,
              'pledgePrice' => nil,
              'lastPledgePrice' => 225.0,
              'onSale' => false,
              'productionStatus' => nil,
              'productionNote' => nil,
              'classification' => 'multi_role',
              'classificationLabel' => 'Multi role',
              'focus' => nil,
              'rsiId' => 14_100,
              'hasImages' => false,
              'hasVideos' => false,
              'hasModules' => false,
              'hasUpgrades' => false,
              'hasPaints' => false,
              'lastUpdatedAt' => enterprise.model.last_updated_at&.utc&.iso8601,
              'lastUpdatedAtLabel' => (I18n.l(enterprise.model.last_updated_at&.utc, format: :label) if enterprise.model.last_updated_at.present?),
              'soldAt' => [],
              'boughtAt' => [],
              'listedAt' => [{
                'id' => 'c38015d3-a8f7-5419-9aed-03e80ec3169a',
                'name' => 'Andromeda',
                'slug' => 'andromeda',
                'storeImage' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageLarge' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageMedium' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'storeImageSmall' =>
                        'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                'category' => 'model',
                'subCategory' => 'multi_role',
                'subCategoryLabel' => 'Multi role',
                'description' => nil,
                'pricePerUnit' => false,
                'sellPrice' => nil,
                'averageSellPrice' => nil,
                'buyPrice' => nil,
                'averageBuyPrice' => nil,
                'rentalPrice1Day' => nil,
                'averageRentalPrice1Day' => nil,
                'rentalPrice3Days' => nil,
                'averageRentalPrice3Days' => nil,
                'rentalPrice7Days' => nil,
                'averageRentalPrice7Days' => nil,
                'rentalPrice30Days' => nil,
                'averageRentalPrice30Days' => nil,
                'locationLabel' => 'sold at New Deal on Port Olisar',
                'confirmed' => true,
                'commodityItemType' => 'Model',
                'commodityItemId' => 'f5412c18-0c29-5b52-b503-ad58947dbe13',
                'shop' => {
                  'id' => 'df2c9942-135d-5cbc-81d6-e1c14b6298bd',
                  'name' => 'New Deal',
                  'slug' => 'new-deal',
                  'type' => 'ships',
                  'typeLabel' => 'Ship Store',
                  'stationLabel' => 'at Port Olisar',
                  'location' => nil,
                  'locationLabel' => 'at Port Olisar in orbit around Crusader',
                  'rental' => false,
                  'buying' => false,
                  'selling' => false,
                  'storeImage' =>
                  'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageLarge' =>
                  'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageMedium' =>
                  'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'storeImageSmall' =>
                  'http://localhost:3000/assets/fallback/store_image-fcc06a6ea7aa61c50d1758b22ccb76734440fe42ad80b87546f612b067d96394.jpg',
                  'refineryTerminal' => nil,
                  'station' => {
                    'name' => 'Port Olisar',
                    'slug' => 'port-olisar'
                  }
                }
              }],
              'rentalAt' => [],
              'manufacturer' => {
                'name' => 'RSI',
                'slug' => 'rsi',
                'code' => nil,
                'logo' => nil
              },
              'loaners' => [],
              'createdAt' => enterprise.model.created_at.utc.iso8601,
              'updatedAt' => enterprise.model.updated_at.utc.iso8601
            },
            'paint' => nil,
            'upgrade' => nil,
            'hangarGroupIds' => enterprise.hangar_group_ids,
            'hangarGroups' => enterprise.hangar_groups.map do |hangar_group|
              {
                'id' => hangar_group.id,
                'slug' => hangar_group.slug,
                'name' => hangar_group.name,
                'color' => hangar_group.color
              }
            end,
            'modelModuleIds' => enterprise.model_module_ids,
            'modelUpgradeIds' => enterprise.model_upgrade_ids,
            'createdAt' => enterprise.created_at.utc.iso8601,
            'updatedAt' => enterprise.updated_at.utc.iso8601
          }]
          assert_equal expected, json
        end

        it 'should return list for index when filtered' do
          query_params = {
            hangarGroupsIn: enterprise.hangar_groups.map(&:slug)
          }
          get :index, params: { q: query_params.to_json }

          assert_response :ok
          json = JSON.parse response.body

          expected = [{
            'id' => enterprise.id,
            'name' => 'Enterprise',
            'serial' => nil,
            'purchased' => true,
            'loaner' => false,
            'flagship' => false,
            'public' => true,
            'nameVisible' => false,
            'saleNotify' => false,
            'alternativeNames' => [],
            'model' => {
              'id' => enterprise.model.id,
              'name' => 'Andromeda',
              'rsiName' => nil,
              'slug' => 'andromeda',
              'rsiSlug' => nil,
              'description' => nil,
              'length' => 61.2,
              'beam' => 10.2,
              'height' => 10.2,
              'mass' => 1000.02,
              'cargo' => 90.0,
              'cargoLabel' => 'Andromeda (90 SCU)',
              'hydrogenFuelTankSize' => nil,
              'quantumFuelTankSize' => nil,
              'minCrew' => 3,
              'maxCrew' => 5,
              'scmSpeed' => nil,
              'afterburnerSpeed' => nil,
              'groundSpeed' => nil,
              'afterburnerGroundSpeed' => nil,
              'pitchMax' => nil,
              'yawMax' => nil,
              'rollMax' => nil,
              'xaxisAcceleration' => nil,
              'yaxisAcceleration' => nil,
              'zaxisAcceleration' => nil,
              'size' => nil,
              'sizeLabel' => nil,
              'storeImage' => enterprise.model.store_image.url,
              'storeImageLarge' => enterprise.model.store_image.large.url,
              'storeImageMedium' => enterprise.model.store_image.medium.url,
              'storeImageSmall' => enterprise.model.store_image.small.url,
              'fleetchartImage' => nil,
              'brochure' => nil,
              'holo' => nil,
              'holoColored' => false,
              'storeUrl' => 'https://robertsspaceindustries.com',
              'salesPageUrl' => nil,
              'price' => nil,
              'pledgePrice' => nil,
              'lastPledgePrice' => 225.0,
              'onSale' => false,
              'productionStatus' => nil,
              'productionNote' => nil,
              'classification' => 'multi_role',
              'classificationLabel' => 'Multi role',
              'focus' => nil,
              'rsiId' => 14_100,
              'hasImages' => false,
              'hasVideos' => false,
              'hasModules' => false,
              'hasUpgrades' => false,
              'hasPaints' => false,
              'lastUpdatedAt' => enterprise.model.last_updated_at&.utc&.iso8601,
              'lastUpdatedAtLabel' => (I18n.l(enterprise.model.last_updated_at&.utc, format: :label) if enterprise.model.last_updated_at.present?),
              'soldAt' => [],
              'boughtAt' => [],
              'rentalAt' => [],
              'manufacturer' => {
                'name' => 'RSI',
                'slug' => 'rsi',
                'code' => nil,
                'logo' => nil
              },
              'loaners' => [],
              'createdAt' => enterprise.model.created_at.utc.iso8601,
              'updatedAt' => enterprise.model.updated_at.utc.iso8601
            },
            'paint' => nil,
            'upgrade' => nil,
            'hangarGroupIds' => enterprise.hangar_group_ids,
            'hangarGroups' => enterprise.hangar_groups.map do |hangar_group|
              {
                'id' => hangar_group.id,
                'slug' => hangar_group.slug,
                'name' => hangar_group.name,
                'color' => hangar_group.color
              }
            end,
            'modelModuleIds' => enterprise.model_module_ids,
            'modelUpgradeIds' => enterprise.model_upgrade_ids,
            'createdAt' => enterprise.created_at.utc.iso8601,
            'updatedAt' => enterprise.updated_at.utc.iso8601
          }]
          assert_equal expected, json
        end

        it 'should return counts for quick-stats' do
          get :quick_stats

          assert_response :ok
          json = JSON.parse response.body

          expected = {
            'total' => 2,
            'classifications' => [{
              'name' => 'explorer',
              'label' => 'Explorer',
              'count' => 1
            }, {
              'name' => 'multi_role',
              'label' => 'Multi role',
              'count' => 1
            }],
            'groups' => [],
            'metrics' => {
              'totalMoney' => 625,
              'totalMinCrew' => 5,
              'totalMaxCrew' => 10,
              'totalCargo' => 130
            }
          }
          assert_equal expected, json
        end

        it 'should return counts for quick-stats' do
          get :quick_stats, params: { q: '{ "classificationIn": ["combat"] }' }

          assert_response :ok
          json = JSON.parse response.body

          expected = {
            'total' => 0,
            'classifications' => [{
              'name' => 'explorer',
              'label' => 'Explorer',
              'count' => 0
            }, {
              'name' => 'multi_role',
              'label' => 'Multi role',
              'count' => 0
            }],
            'groups' => [],
            'metrics' => {
              'totalMoney' => 0,
              'totalMinCrew' => 0,
              'totalMaxCrew' => 0,
              'totalCargo' => 0
            }
          }
          assert_equal expected, json
        end

        it 'should render 200 for hangar-items' do
          get :hangar_items

          assert_response :ok
          json = JSON.parse response.body

          expected = %w[
            600i
            andromeda
          ]
          assert_equal expected, json
        end
      end
    end
  end
end
