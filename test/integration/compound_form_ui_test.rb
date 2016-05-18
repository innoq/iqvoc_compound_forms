# encoding: UTF-8

# Copyright 2011-2016 innoQ Deutschland GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require File.join(File.expand_path(File.dirname(__FILE__)), '../integration_test_helper')

class CompoundFormUITest < ActionDispatch::IntegrationTest
  setup do
    login 'administrator'
  end


  test 'compound form ui existence' do
    create_compound_form_label(
      'Luftreinhaltungskosten' => %w(Luft Reinhaltung Kosten)
    )

    label = Iqvoc::XLLabel.base_class.find_by(value: 'Luftreinhaltungskosten')
    visit label_path(label, lang: 'en', format: 'html')

    assert page.has_content? 'Luftreinhaltungskosten'

    within('#compound_forms') do |ref|
      assert page.has_content? 'Compound from'
      assert page.has_content? 'Luft, Reinhaltung, Kosten'

      click_link 'Reinhaltung'
    end

    within('#compound_forms') do |ref|
      assert page.has_content? 'Compound from'
      assert page.has_content? 'Luftreinhaltungskosten'
    end
  end

  test 'compound form ui removement' do
    create_compound_form_label(
      'Abtrennung und Transmutation radioaktiven Abfalls' => %w(Abtrennung Transmutation radioaktiv Abfall)
    )

    label = Iqvoc::XLLabel.base_class.find_by(value: 'Abtrennung und Transmutation radioaktiven Abfalls')
    visit label_path(label, lang: 'en', format: 'html')

    assert page.has_content? 'Abtrennung und Transmutation radioaktiven Abfalls'

    within('#compound_forms') do |ref|
      assert page.has_content? 'Compound from'
      assert page.has_content? 'Abtrennung, Transmutation, radioaktiv, Abfall'
    end

    click_link_or_button 'Create new version'
    assert page.has_content? 'Instance copy has been created and locked.'

    # remove last component (fill in first 3)
    compound_form_origins = label.compound_form_contents.map {|cfc| cfc.label.origin}
    first_three_origins = compound_form_origins[0..2]
    fill_in 'label_inline_compound_form_origins_', with: first_three_origins.join(', ')

    # save changes
    click_link_or_button 'Save'

    assert page.has_content? 'Label has been successfully modified.'

    within('#compound_forms') do |ref|
      assert page.has_content? 'Compound from'
      assert page.has_content? 'Abtrennung, Transmutation, radioaktiv' # without 'Abfall'
    end
  end


  test 'remove compound form completely from ui' do
    create_compound_form_label(
      'Hausmüllähnlicher Gewerbeabfall' => %w(Abfall hausmüllähnlich Gewerbe)
    )

    label = Iqvoc::XLLabel.base_class.find_by(value: 'Hausmüllähnlicher Gewerbeabfall')
    visit label_path(label, lang: 'en', format: 'html')

    assert page.has_content? 'Hausmüllähnlicher Gewerbeabfall'

    within('#compound_forms') do |ref|
      assert page.has_content? 'Compound from'
      assert page.has_content? 'Abfall, hausmüllähnlich, Gewerbe'
    end

    click_link_or_button 'Create new version'
    assert page.has_content? 'Instance copy has been created and locked.'

    # clear compound forms completely
    fill_in 'label_inline_compound_form_origins_', with: ''

    # save changes
    click_link_or_button 'Save'

    assert page.has_content? 'Label has been successfully modified.'

    within('#compound_forms') do |ref|
      assert page.has_content? 'Compound from'
      refute page.has_content? 'Abfall, hausmüllähnlich, Gewerbe'
    end
  end
end
