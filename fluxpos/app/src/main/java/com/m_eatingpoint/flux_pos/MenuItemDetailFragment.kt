package com.m_eatingpoint.flux_pos

import android.app.Activity
import android.support.design.widget.CollapsingToolbarLayout
import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView

import com.m_eatingpoint.flux_pos.dummy.DummyContent

/**
 * A fragment representing a single Menu Item detail screen.
 * This fragment is either contained in a [MenuItemListActivity]
 * in two-pane mode (on tablets) or a [MenuItemDetailActivity]
 * on handsets.
 */
/**
 * Mandatory empty constructor for the fragment manager to instantiate the
 * fragment (e.g. upon screen orientation changes).
 */
class MenuItemDetailFragment : Fragment() {

    /**
     * The dummy content this fragment is presenting.
     */
    private var mItem: DummyContent.DummyItem? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (arguments.containsKey(ARG_ITEM_ID)) {
            // Load the dummy content specified by the fragment
            // arguments. In a real-world scenario, use a Loader
            // to load content from a content provider.
            mItem = DummyContent.ITEM_MAP[arguments.getString(ARG_ITEM_ID)]

            val activity = this.activity
            val appBarLayout = activity.findViewById<View>(R.id.toolbar_layout) as CollapsingToolbarLayout
            if (appBarLayout != null) {
                appBarLayout.title = mItem!!.content
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        val rootView = inflater!!.inflate(R.layout.menuitem_detail, container, false)

        // Show the dummy content as text in a TextView.
        if (mItem != null) {
            (rootView.findViewById<View>(R.id.menuitem_detail) as TextView).text = mItem!!.details
        }

        return rootView
    }

    companion object {
        /**
         * The fragment argument representing the item ID that this fragment
         * represents.
         */
        val ARG_ITEM_ID = "item_id"
    }
}
