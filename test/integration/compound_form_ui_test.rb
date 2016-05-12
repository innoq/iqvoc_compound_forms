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
end
