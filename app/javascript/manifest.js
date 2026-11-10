// Central export of iqvoc_compound_forms' own JavaScript, for other
// apps/gems to import (via `import 'iqvoc_compound_forms'`, resolved
// through package.json's "main"). Does not start Rails/UJS - see
// application.js for that.
//
// iqvoc_skosxl's own manifest already pulls in iqvoc's, so importing it
// alone is enough - no need to also import 'iqvoc' directly.
import 'iqvoc_skosxl'

import './iqvoc_compound_forms/compound_forms'
